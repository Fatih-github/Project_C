
import java.util.ArrayList;
import java.util.HashMap;

public class DataHelper {


    public static ArrayList<String> getJsonsFromString(String input){
        ArrayList<String> out = new ArrayList<>();
        String temp = "";
        boolean reading = false;
        for (char c : input.toCharArray()){
            if(c == '{'){
                reading = true;
            }else if (c == '}'){
                reading = false;
                out.add(temp);
                temp = "";
            }
            if(reading){
                temp += c;
            }
        }
        return out;
    }

    public static HashMap<String, String> getHashmapFromJsonString(String input){
        HashMap<String, String> out = new HashMap<>();
        String[] entries = input.replaceAll("'", "").replaceAll("\\{", "").replaceAll("}", "").split(",");
        System.out.println("\n\ninput " + input);
        for (String entry : entries){
            System.out.println("entry before format " + entry);
            entry.replaceAll("'", "").replaceAll("\\{", "").replaceAll("}", "");
            System.out.println("entry after format " + entry);
            String[] kv = entry.split(":");
            System.out.println("Entry put as:  K: '" + kv[0] + "' V: '" + kv[1] + "'");
            out.put(kv[0], kv[1]);
        }
        return out;
    }

    public static ArrayList<HashMap<String, String>>  getHashmapsFromJsonString(String input){
        ArrayList<HashMap<String, String>> out = new ArrayList<>();
        ArrayList<String> jSrings = getJsonsFromString(input);
        for (String jstring: jSrings) {
            out.add(getHashmapFromJsonString(jstring));
        }
        return out;
    }
}
