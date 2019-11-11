package com.as.game.menu;

import java.awt.Color;

import com.gb.game.Game;

public class PointObject extends MenuObject {

	int x, y, timer, transX, transY;
	float colorScale, transTheta;
	int r, g, b;
	Color c;

	public PointObject(int x, int y) {
		r = Color.GREEN.getRed();
		g = Color.GREEN.getGreen();
		b = Color.GREEN.getBlue(); // setup the colorshift
		this.x = x;
		this.y = y; // set local variables
		timer = 0; // set the timer for rendering
		transX = x;
		transY = 800 - y; // transpose from one coordinate system to the other

		// calculate transTheta
		transTheta = (float) Math.atan(((double) y) / (double) (x));
	}

	public void setTimer(int time) { // set the render timer
		timer = time;
	}

	public void isHover() {
	}

	public void isNotHover() {
	}

	public void onClick() {
	}

	public void tick() {
		if (timer > 0)
			timer--;
		colorScale = timer / 251.0f;
		System.out.println(colorScale);
		c = new Color((int) (colorScale * r), (int) (colorScale * g), (int) (colorScale * b), (int)(colorScale * 255));
	}

	@Override
	public void render() {
		// TODO Auto-generated method stub
		if (timer > 0) {
			Game.getScreen().renderCircle(transX, transY, 10, c, true);
		}
	}

}
