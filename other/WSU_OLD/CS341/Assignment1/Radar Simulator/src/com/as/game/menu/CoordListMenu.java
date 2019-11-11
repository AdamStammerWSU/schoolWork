package com.as.game.menu;

import java.util.ArrayList;

import com.as.game.menu.MenuObject.Button;
import com.gb.game.Game;
import com.gb.game.graphics.Font;

public class CoordListMenu extends Menu {

	ArrayList<PointObject> points;
	Button back, up, down;
	int page = 0, maxPage = 0, itemsPerPage = 15;

	public void init() {
		points = GridMenu.loadPoints();
		back = new Button(350, 50, "Back") { // setup the back button
			public void onClick() {
				Game.currentMenu = Game.gridMenu;
			}
		};
		//maxPage = points.size() / itemsPerPage;
	}

	public void tick() {
		super.tick();
		back.tick();
	}

	public void render() {
		super.render();
		back.render();
		for (int i = 0; i < points.size(); i++) { // render all of the coordinates in a list
			Font.render(points.get(i).x + ", " + points.get(i).y, 350, 100 + 25 * i, 1.5);
		}
	}

}
