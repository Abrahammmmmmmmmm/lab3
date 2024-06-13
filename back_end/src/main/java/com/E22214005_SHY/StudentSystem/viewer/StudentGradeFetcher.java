package com.E22214005_SHY.StudentSystem.viewer;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class StudentGradeFetcher {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/StudentSystemDatabase";
    private static final String USER = "root";
    private static final String PASS = "Shy123321.";

    public static Map<String, Double> fetchGrades(String studentId) {
        Map<String, Double> grades = new HashMap<>();
        String query = "SELECT Course_Name, Score FROM tb_Score WHERE Student_Id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, studentId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                grades.put(rs.getString("Course_Name"), rs.getDouble("Score"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return grades;
    }
}
