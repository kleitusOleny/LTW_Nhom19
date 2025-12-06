package db;

import model.User;
import org.jdbi.v3.core.Jdbi;

import java.io.*;
import java.util.List;
import java.util.Properties;

public class JdbiConnector {
    private static Jdbi jdbi;

    public static Jdbi get() {
        if (jdbi == null) {
            jdbi = Jdbi.create("jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" + DBProperties.database(), DBProperties.username(), DBProperties.password());
        }
        return jdbi;
    }

    static class DBProperties {
        static Properties prop = new Properties();

        static {
            try {
                File f = new File("db.properties");
                InputStream is = null;
                if (f.exists()) {
                    is = new FileInputStream(f);
                } else {
                    is = DBProperties.class.getClassLoader().getResourceAsStream("db.properties");
                }
                if (is != null) {
                    prop.load(is);
                } else {
                    throw new FileNotFoundException("property file 'db.properties' not found in the classpath");
                }
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        public static String host() {
            return prop.getProperty("db.host");
        }

        public static int port() {
            return Integer.parseInt(prop.getProperty("db.port"));
        }

        public static String username() {
            return prop.getProperty("db.username");
        }

        public static String password() {
            return prop.getProperty("db.password");
        }

        public static String database() {
            return prop.getProperty("db.dbName");
        }

    }

}
