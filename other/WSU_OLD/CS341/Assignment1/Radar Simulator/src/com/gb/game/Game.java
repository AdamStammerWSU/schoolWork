package com.gb.game;

/*
 * Adam Stammer 
 * Radar Simulation
 * CS341
 * 10/21/2018
 * 
 */

import java.awt.BorderLayout;
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.image.BufferStrategy;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferInt;

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import com.as.game.menu.CoordListMenu;
import com.as.game.menu.GridMenu;
import com.as.game.menu.Menu;
import com.gb.game.graphics.Image;
import com.gb.game.graphics.Screen;

public class Game extends Canvas implements Runnable {
	private static final long serialVersionUID = 1L;
	public static int WIDTH = 800;
	public static int HEIGHT = 800;
	public static int SCALE = 1;
	public static String NAME = "Game";
	public static Game instance;
	public KeyHandler input;
	public static MouseHandler mouse;
	private JFrame frame;
	Thread mainThread;
	public boolean running = false;
	public int tickCount = 0;
	public BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
	public int[] pixels = ((DataBufferInt) image.getRaster().getDataBuffer()).getData();
	public static Screen screen;

	public static Menu currentMenu;
	public static GridMenu gridMenu = new GridMenu();
	public static CoordListMenu coordListMenu = new CoordListMenu();
	public String fileName = "test.txt";

	public void init() {
		instance = this;
		input = new KeyHandler(this);
		mouse = new MouseHandler(this);
		screen = new Screen(WIDTH, HEIGHT);

		fileName = JOptionPane.showInputDialog("What is the input file?: ");
		currentMenu = gridMenu;

	}

	public void tick() {
		tickCount++;
		mouse.poll();
		input.poll();

		currentMenu.tick();
	}

	public void render() {
		screen.clear(Color.BLACK);

		currentMenu.render();

		postRender();
	}

	public void postRender() {
		BufferStrategy bs = getBufferStrategy();
		if (bs == null) {
			createBufferStrategy(3);
			return;
		}
		Graphics2D g = (Graphics2D) bs.getDrawGraphics();
		g.setColor(Color.BLACK);
		g.fillRect(0, 0, getWidth(), getHeight());
		g.drawImage(screen.image, 0, 0, WIDTH, HEIGHT, null);
		g.dispose();
		bs.show();
	}

	public void run() {

		init();

		long lastTime = System.nanoTime();
		double nsPerTick = 1000000000.0 / 60.0;
		double unprocessed = 0.0;
		int ticks = 0, frames = 0;
		long lastTimer = System.currentTimeMillis();

		while (running) {
			long now = System.nanoTime();
			unprocessed += (now - lastTime) / nsPerTick;
			lastTime = now;
			boolean shouldRender = false;

			while (unprocessed >= 1) {
				ticks++;
				tick();
				unprocessed--;
				shouldRender = true;
			}

			if (shouldRender) {
				frames++;
				render();
			}

			if (System.currentTimeMillis() - lastTimer >= 1000) {
				lastTimer += 1000;
				frame.setTitle(ticks + " ticks, " + frames + " frames");
				ticks = frames = 0;
			}
		}
	}

	public synchronized void start() {
		mainThread = new Thread(this, "MAIN_game");
		mainThread.start();
		running = true;
	}

	public synchronized void stop() {
		running = false;
	}

	public static void main(String[] args) {
		Game game = new Game();
		game.frame = new JFrame(NAME);
		game.frame.setMinimumSize(new Dimension(WIDTH * SCALE, HEIGHT * SCALE));
		game.frame.setMaximumSize(new Dimension(WIDTH * SCALE, HEIGHT * SCALE));
		game.frame.setPreferredSize(new Dimension(WIDTH * SCALE, HEIGHT * SCALE));
		game.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		game.frame.setLayout(new BorderLayout());
		game.frame.setResizable(false);
		game.frame.setLocationRelativeTo(null);
		game.frame.add(game);
		game.frame.setIconImage(new Image("/font/cb.png").image);
		game.frame.pack();
		game.frame.setVisible(true);
		game.start();
	}

	public static Screen getScreen() {
		return screen;
	}

	public static MouseHandler getMouseHandler() {
		return mouse;
	}
}