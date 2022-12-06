package kr.eddi.ztz_process.utility.order;

import java.util.Random;

public class setRandomOrderNo {
    public static int makeIntCustomRandom(int min, int max) {
        Random random = new Random();
        return random.nextInt(max - min) + min;
    }
}
