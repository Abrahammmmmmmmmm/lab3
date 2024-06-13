package com.E22214005_SHY.StudentSystem.viewer;

import javax.swing.*;
import java.awt.*;
import java.util.Map;

import com.E22214005_SHY.StudentSystem.util.WindowUtil;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.LineAndShapeRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

public class StudentScoreViewer {
    public static void displayStudentGrades(String studentId) {
        JFrame frame = new JFrame("学生成绩查看器");
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setSize(800, 600);

        // 设置布局管理器
        frame.setLayout(new BorderLayout());

        Map<String, Double> grades = StudentGradeFetcher.fetchGrades(studentId);

        JPanel chartPanel = createChartPanel(grades);
        frame.add(chartPanel, BorderLayout.CENTER);

        WindowUtil.setFrameCenter(frame);
        frame.setVisible(true);
        frame.toFront(); // 确保窗口显示在前台
        frame.requestFocus(); // 请求窗口获得焦点
    }

    public static JPanel createChartPanel(Map<String, Double> grades) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        grades.forEach((subject, score) -> dataset.addValue(score, "成绩", subject));

        JFreeChart lineChart = ChartFactory.createLineChart(
                "学生成绩",
                "课程",
                "成绩",
                dataset,
                PlotOrientation.VERTICAL,
                false, true, false);

        CategoryPlot plot = lineChart.getCategoryPlot();
        LineAndShapeRenderer renderer = new LineAndShapeRenderer();
        plot.setRenderer(renderer);

        // Customizing the plot to support Chinese characters
        Font font = new Font("宋体", Font.PLAIN, 12);
        lineChart.getTitle().setFont(font);
        plot.getDomainAxis().setLabelFont(font);
        plot.getDomainAxis().setTickLabelFont(font);
        plot.getRangeAxis().setLabelFont(font);
        plot.getRangeAxis().setTickLabelFont(font);

        return new ChartPanel(lineChart);
    }

    public static void main(String[] args) {
        StudentScoreViewer.displayStudentGrades("E22214005");
    }
}
