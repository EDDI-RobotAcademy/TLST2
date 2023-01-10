package kr.eddi.ztz_process.utility.order;

public class validationToken {

    static public String validationToken(String token) {
        if(token.length() > 36){
            String subStringToken = token.substring(1,37);
            return subStringToken;
        }
        return token;
    }

}
