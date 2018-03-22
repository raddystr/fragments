import java.util.Scanner;

public class currencyconvertor {
    public static void main(String[]args) {
        Scanner scanner = new Scanner(System.in);
        double currency = Double.parseDouble(scanner.nextLine());
        String inputValue = scanner.nextLine();
        String outputValue = scanner.nextLine();

        if (inputValue.equals("USD")) {
            currency = currency * 1.79549;
        } else if (inputValue.equals("EUR")) {
            currency = currency * 1.95583;
        } else if (inputValue.equals("GBP")) {
            currency = currency * 2.53405;
        } else if (inputValue.equals("BGN")) {
            currency = currency * 1;
        }

        if (outputValue.equals("USD")) {
            currency = currency / 1.79549;
        } else if (outputValue.equals("EUR")) {
            currency = currency /1.95583;
        } else if (outputValue.equals("GBP")) {
            currency =currency / 2.53405;
        }else if (outputValue.equals("BGN")) {
            currency =currency / 1;
        }


        System.out.println(currency);
    }
}
