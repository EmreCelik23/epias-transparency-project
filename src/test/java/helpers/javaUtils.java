package helpers;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class javaUtils {
    public static String csvFormatter(String str){
        return str.replace(';',',');
    }

    public static String changeDateFormat(String date, String format){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);
        ZonedDateTime dateTime = ZonedDateTime.parse(date);
        return dateTime.format(formatter);
    }

    public static String dateFormatter(String str){
        DateTimeFormatter formatter = DateTimeFormatter.ISO_OFFSET_DATE_TIME;
        OffsetDateTime dateTime = OffsetDateTime.parse(str, formatter);
        return dateTime.toLocalDate().format(DateTimeFormatter.ofPattern("dd.MM.yyyy"));
    }

    public static Integer integerFormatter(String str){
        return Integer.parseInt(str.replace(".",""));
    }

}
