package com.company;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        Scanner console = new Scanner(System.in);

        List<String> dimensions = Arrays
                .stream(console.nextLine()
                        .split(", "))
                .collect(Collectors.toList());

        int rows = Integer.parseInt(dimensions.get(0));
        int cols = Integer.parseInt(dimensions.get(1));

        int[][] matrix= new int[rows][cols];

        for (int row = 0; row < matrix.length ; row++) {
            String [] value = console.nextLine().split(", ");
            for (int col = 0; col <matrix[row].length ; col++) {
                matrix[row][col] = Integer.parseInt(value[col]);
            }
        }
        int sum = 0;
        for (int[] row : matrix) {
            for (int col : row) {
                sum+=col;
            }
        }
        System.out.println(matrix.length);
        System.out.println(cols);
        System.out.println(sum);
    }
}

