package com.company;
import java.util.ArrayDeque;;
import java.util.Scanner;

public class Main {
    
    public static void main(String[] args) {
        
        Scanner console = new Scanner(System.in);
        int number = Integer.parseInt(console.nextLine());
        ArrayDeque<Integer>stack  = new ArrayDeque<>();
        while (number>0){
            int reminder = number%2;
            stack.push(reminder);
            number/=2;
        }
        while (!stack.isEmpty()) {
            System.out.print(stack.pop());
        }
    }
}
