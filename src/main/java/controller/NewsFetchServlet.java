package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import db.JdbiConnector;
import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jdbi.v3.core.Jdbi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/fetch-news")
public class NewsFetchServlet extends HttpServlet {
    private final Jdbi jdbi = JdbiConnector.get();
    public static Dotenv dotenv;

    static {
        dotenv = Dotenv.configure()
                .ignoreIfMissing()
                .load();
    }

    private static final String API_KEY = dotenv.get("NEWS_API_KEY");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String query = java.net.URLEncoder.encode("wine OR vang OR rượu", "UTF-8");
            String apiUrl = "https://newsdata.io/api/1/news?apikey=" + API_KEY +
                    "&language=vi&q=" + query;

            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            int responseCode = conn.getResponseCode();
            if (responseCode < 200 || responseCode >= 300) {
                response.setContentType("application/json; charset=UTF-8");
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "Không có tin tức mới. API trả về lỗi: " + responseCode);
                response.getWriter().write(errorResponse.toString());
                return;
            }

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), "UTF-8"));

            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }
            reader.close();

            JsonObject root = JsonParser.parseString(json.toString()).getAsJsonObject();
            JsonArray results = root.getAsJsonArray("results");

            if (results == null || results.size() == 0) {
                response.setContentType("application/json; charset=UTF-8");
                JsonObject emptyResponse = new JsonObject();
                emptyResponse.addProperty("success", false);
                emptyResponse.addProperty("message", "Không có tin tức mới.");
                response.getWriter().write(emptyResponse.toString());
                return;
            }

            // Return news as JSON for approval
            response.setContentType("application/json; charset=UTF-8");
            JsonObject successResponse = new JsonObject();
            successResponse.addProperty("success", true);
            successResponse.addProperty("message", "Tìm thấy " + results.size() + " tin tức mới!");
            successResponse.add("news", results);
            response.getWriter().write(successResponse.toString());

        } catch (IOException e) {
            response.setContentType("application/json; charset=UTF-8");
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Không thể kết nối đến nguồn tin tức. Vui lòng thử lại sau.");
            response.getWriter().write(errorResponse.toString());
            e.printStackTrace();
        } catch (Exception e) {
            response.setContentType("application/json; charset=UTF-8");
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Đã xảy ra lỗi khi xử lý tin tức: " + e.getMessage());
            response.getWriter().write(errorResponse.toString());
            e.printStackTrace();
        }
    }

    // New method to save selected news items
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String newsDataJson = request.getParameter("newsData");

        if (newsDataJson == null || newsDataJson.isEmpty()) {
            response.setContentType("application/json; charset=UTF-8");
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Không có dữ liệu tin tức.");
            response.getWriter().write(errorResponse.toString());
            return;
        }

        try {
            JsonArray newsArray = JsonParser.parseString(newsDataJson).getAsJsonArray();
            saveToDB(newsArray);

            response.setContentType("application/json; charset=UTF-8");
            JsonObject successResponse = new JsonObject();
            successResponse.addProperty("success", true);
            successResponse.addProperty("message", "Đã thêm " + newsArray.size() + " tin tức thành công!");
            response.getWriter().write(successResponse.toString());

        } catch (Exception e) {
            response.setContentType("application/json; charset=UTF-8");
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Lỗi khi lưu tin tức: " + e.getMessage());
            response.getWriter().write(errorResponse.toString());
            e.printStackTrace();
        }
    }

    private void saveToDB(JsonArray results) {

        String sql = """
                    INSERT INTO blogs
                    (title, content, upload_at, display, blog_image, slug, create_at, update_at, is_delete)
                    VALUES (:title, :content, :upload_at, :display, :blog_image, :slug, NOW(), NOW(), 0)
                """;

        jdbi.useHandle(handle -> {

            for (JsonElement e : results) {
                JsonObject news = e.getAsJsonObject();

                String title = get(news, "title");
                String content = get(news, "description");
                String image = get(news, "image_url");
                String pubDate = get(news, "pubDate");
                String slug = slugify(title);

                handle.createUpdate(sql)
                        .bind("title", title)
                        .bind("content", content)
                        .bind("upload_at", pubDate)
                        .bind("display", 1)
                        .bind("blog_image", image)
                        .bind("slug", slug)
                        .execute();
            }
        });
    }

    private String get(JsonObject obj, String key) {
        return obj.has(key) && !obj.get(key).isJsonNull()
                ? obj.get(key).getAsString()
                : null;
    }

    private String slugify(String text) {
        if (text == null)
            return null;
        String slug = text.toLowerCase();
        slug = java.text.Normalizer.normalize(slug, java.text.Normalizer.Form.NFD);
        slug = slug.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        slug = slug.replaceAll("[^a-z0-9]+", "-");
        return slug.replaceAll("(^-|-$)", "");
    }
}
