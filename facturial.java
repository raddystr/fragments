package com.company;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        int a = scanner.nextInt();
        int b = scanner.nextInt();
        int aInitila=a;

        BigInteger result = BigInteger.ONE;

        do {
            result = result.multiply(BigInteger.valueOf(a));
            a++;
        } while (a <= b);

        System.out.printf("product[%d..%d] = %d",aInitila, b,result);
    }
}