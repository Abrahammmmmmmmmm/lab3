package com.E22214005_SHY.StudentSystem.frame;

import java.awt.Graphics;
import java.awt.Image;

import javax.swing.ImageIcon;
import javax.swing.JPanel;

public class ImagePanel extends JPanel{
	private ImageIcon icon;  
	private Image img;

	public ImagePanel() {
		// 创建一个ImageIcon对象，从当前项目的资源路径加载图片文件"/1.png"
		icon = new ImageIcon(StudentSystemMainFrame.class.getResource("/1.png"));
		// 从ImageIcon获取Image对象
		img = icon.getImage();
	}

	public void paintComponent(Graphics g) {
		// 调用父类的paintComponent方法，以确保组件正常绘制背景
		super.paintComponent(g);

		// 获取ImagePanel的宽度和高度，以便计算图片居中显示的位置
		int panelWidth = getWidth();
		int panelHeight = getHeight();

		// 计算图片在面板上居中时的坐标
		int imageX = (panelWidth - img.getWidth(null)) / 2;
		int imageY = (panelHeight - img.getHeight(null)) / 2;

		// 在面板上绘制图片，使用计算出的坐标确保图片居中
		g.drawImage(img, imageX, imageY, null);
	}
}
