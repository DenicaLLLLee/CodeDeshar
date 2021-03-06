/*
 * File: GStoplightGUI.java
 * ------------------------
 * This program illustrates the construction of a simple GUI.
 */

import acm.program.*;
import java.awt.event.*;
import javax.swing.*;

/**
 * This class displays three buttons at the south edge of the window.
 * Pressing the button changes the state of the stoplight accordingly.
 */

public class GStoplightGUI extends GraphicsProgram {

	public static void main(String[] args) {
		Program.main(args);
	}

	public void init() {
		stoplight = new GStoplight();
		add(stoplight, getWidth() / 2, getHeight() / 2);
		add(new JButton("Red"), SOUTH);
		add(new JButton("Yellow"), SOUTH);
		add(new JButton("Green"), SOUTH);
		addActionListeners();
	}

	public void actionPerformed(ActionEvent e) {
		String cmd = e.getActionCommand();
		stoplight.setState(cmd);
	}

/* Private instance variables */
	private GStoplight stoplight;
}
