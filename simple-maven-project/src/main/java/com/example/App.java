package com.example;

public class App {
    public static void main(String[] args) {
        User user = new User("Anjali", 25);
        System.out.println("User: " + user.getName() + ", Age: " + user.getAge());
    }

    public int add(int a, int b) {
        return a + b;
    }
}
