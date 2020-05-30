package com.as.game.menu;

/*
 * Adam Stammer 
 * Radar Simulation
 * CS341
 * 10/21/2018
 * 
 */

import java.awt.Color;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import com.as.game.menu.MenuObject.Button;
import com.gb.game.Game;
import com.gb.game.graphics.Image;

public class GridMenu extends Menu {

	enum Sweep {
		horizontal, vertical, radial
	} // used to tell what type of sweep to do

	Sweep sweep = Sweep.horizontal; // the current sweep mode
	int gridWidth = 50; // how far apart to draw the gridlines
	Button horiz, vert, rad, list; // buttons to switch the sweep mode
	Button buttons[] = { horiz, vert, rad, list }; // store the buttons in an array for ease of use
	int xBar, yBar;
	float thetaBar; // positional values for the sweepbar
	Image sweepBar, sweepBarH;
	ArrayList<PointObject> points;

	public static ArrayList<PointObject> loadPoints() { // this was way more of a pain than it should've been
		ArrayList<PointObject> p = new ArrayList<PointObject>(); // initialize a place to store the points
		FileReader fr = null;
		try {
			fr = new FileReader("test.txt"); // open the file
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		char c[] = new char[500];
		try {
			fr.read(c); // read from the file
		} catch (IOException e) {
			e.printStackTrace();
		}
		String s = new String(c); // concat into a string
		String coords[] = s.replaceAll("\n", ",").replaceAll(" ", "").split(","); // format and split into coordinates
		for (int i = 0; i < coords.length - 1; i += 2) {
			int x = Integer.valueOf(coords[i].trim()); // get the x
			int y = Integer.valueOf(coords[i + 1].trim()); // get the y
			p.add(new PointObject(x, y)); // add the point to the list
		}
		return p;
	}

	public void init() { // initialization
		points = loadPoints();
		horiz = new Button(10, 10, "Horizontal") { // setup the horizontal button
			public void onClick() {
				sweep = Sweep.horizontal; // set the sweepmode to horizontal
				xBar = 0;
				yBar = 0;
			}
		};
		vert = new Button(265, 10, "Vertical") { // setup the vertical button
			public void onClick() {
				sweep = Sweep.vertical; // set the sweepmode to vertical
				xBar = 0;
				yBar = 0;
			}
		};
		rad = new Button(480, 10, "Radial") { // setup the radial button
			public void onClick() {
				sweep = Sweep.radial; // set sweepmode to radial
				xBar = 0;
				yBar = 0;
				thetaBar = 0;
			}
		};
		list = new Button(660, 10, "List") {
			public void onClick() {
				Game.currentMenu = Game.coordListMenu;
			}
		};

		sweepBar = new Image("/textures/sweepBar.png"); // load the image for the sweepBar

		sweepBarH = new Image("/textures/sweepBarH.png");
	}

	public void tick() {
		super.tick();

		// update all of the buttons
		for (Button b : buttons) {
			b.tick();
		}

		// ---JUICY PART---//
		// this is where the "collision detection" occurs
		for (PointObject p : points) {
			p.tick();
			switch (sweep) {
			case horizontal:
				if (Math.abs(p.transY - yBar) <= 3) // if they're within 3 pixels, restart the render timer
					p.setTimer(250);
				break;
			case vertical:
				if (Math.abs(p.transX - xBar) <= 3)
					p.setTimer(250);
				break;
			case radial:
				if (Math.abs(p.transTheta - thetaBar) <= (Math.PI / 200))
					p.setTimer(250);
				break;
			}
		}

		// update the position and points based on sweepType
		switch (sweep) {
		case horizontal:
			yBar += 3;
			yBar %= 800;
			break;
		case vertical:
			xBar += 3;
			xBar %= 800;
			break;
		case radial:
			thetaBar += Math.PI / 200;
			thetaBar %= Math.PI * 2;
			break;
		}

	}

	public void render() {

		// render vertical grid lines
		for (int x = 0; x < (Game.getScreen().w / gridWidth); x++) {
			Game.getScreen().renderRect(gridWidth * x, 0, 1, Game.getScreen().h, Color.GREEN, true);
		}
		// render horizontal grid lines
		for (int y = 0; y < (Game.getScreen().h / gridWidth); y++) {
			Game.getScreen().renderRect(0, 50 + (gridWidth * y), Game.getScreen().w, 1, Color.GREEN, true);
		}

		// rendering of the points

		// rendering of the sweepBar
		switch (sweep) {
		case horizontal:
			Game.getScreen().render(sweepBarH, xBar, yBar, 2);
			break;
		case vertical:
			Game.getScreen().render(sweepBar, xBar, yBar, 1);
			break;
		case radial:
			Game.getScreen().renderLine(0, 800, (int) (1200 * Math.cos(thetaBar)),
					800 - (int) (1200 * Math.sin(thetaBar)), 4, Color.GREEN);
			break;
		}

		// add a dashboard background at the top of the screen to house the buttons
		Game.getScreen().renderRect(0, 0, Game.getScreen().w, 50, Color.DARK_GRAY, true);

		// render all of the buttons on the screen
		for (Button b : buttons) {
			b.render();
		}

		for (PointObject p : points)
			p.render();

		super.render();
	}

}
