package services;

import dao.FeedbackDAO;
import model.Feedback;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class FeedbackService {
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    public void insertFeedback(int id, String title, String content) {
        Feedback feedback = new Feedback();
        feedback.setuId(id);
        feedback.setTitle(title);
        feedback.setContent(content);
        feedback.setCreateAt(Timestamp.valueOf(LocalDateTime.now()));
        feedback.setDelete(false);
        feedback.setStatus(false);

        feedbackDAO.create(feedback);
    }

    public void updateFeedback(int id, boolean status){
        Feedback feedback = new Feedback();
        feedback.setId(id);
        feedback.setStatus(status);
        feedback.setUpdateAt(Timestamp.valueOf(LocalDateTime.now()));

        feedbackDAO.update(feedback);
    }

    public void deleteFeedback(int id) {
        Feedback feedback = new Feedback();
        feedback.setId(id);

        feedbackDAO.delete(feedback);
    }
}
