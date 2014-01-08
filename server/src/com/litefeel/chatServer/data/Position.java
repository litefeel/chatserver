package com.litefeel.chatServer.data;

public class Position {

	public float x;
	public float y;
	public float vx;
	public float vy;
	public float time;
	
	public Position() {
		this.x = 0;
		this.y = 0;
		this.vx = 0;
		this.vy = 0;
		this.time = 0;
	}
	
	public Position(float x, float y, float vx, float vy, float time) {
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		this.time = time;
	}

	public static void toArray(Position pos, float[] arr, int from) {
		arr[from + 0] = pos.x;
		arr[from + 1] = pos.y;
		arr[from + 2] = pos.vx;
		arr[from + 3] = pos.vy;
		arr[from + 4] = pos.time;
	}
}
