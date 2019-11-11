package com.as.game.menu;

import java.awt.Color;
import java.awt.Rectangle;

import com.gb.game.Game;
import com.gb.game.graphics.Font;

public abstract class MenuObject {

	protected int x, y, width, height;

	public abstract void isHover();

	public abstract void isNotHover();

	public abstract void onClick();

	public abstract void render();

	public void tick() {
		if (Game.getMouseHandler().getRect().intersects(getRect())) {
			isHover();
			if (Game.getMouseHandler().buttonDownOnce(1))
				onClick();
		} else
			isNotHover();
	}

	private Rectangle getRect() {
		return new Rectangle(x, y, width, height);
	}

	public static class Button extends MenuObject {

		protected Color color = Color.blue;
		protected String text = "";

		public Button(int x, int y, String text) {
			this.x = x;
			this.y = y;
			this.text = text;
			this.width = (20 * text.length()) + 20;
			this.height = 30;

		}

		public void isHover() {
			if (color.getRGB() != 0x00ff7f)
				color = new Color(0x00ff7f);
		}

		public void isNotHover() {
			if (color.getRGB() != 0x007fff)
				color = new Color(0x007fff);

		}

		public void onClick() {

		}

		public void render() {

			Game.getScreen().renderRect(x, y, width, height, color, true);

			Font.render(text, x + 10, y + 5, 2);

		}

	}

	public static class Option extends Button {

		private String o1, o2;
		protected boolean one;

		public Option(int y, String text, String o1, String o2, boolean one) {
			super(50, y, text);
			this.o1 = o1;
			this.o2 = o2;
			width = 700;
			this.one = one;
		}

		public void onClick() {
			one = !one;
		}

		public void render() {
			Game.getScreen().renderRect(x, y, width, height, color, true);
			Font.render(text, x + 10, y + 5, 2);
			if (one)
				Font.render(o1, 800 - ((o1.length() * 20) + 60), y + 5, 2);
			else
				Font.render(o2, 800 - ((o2.length() * 20) + 60), y + 5, 2);

		}

	}
}
