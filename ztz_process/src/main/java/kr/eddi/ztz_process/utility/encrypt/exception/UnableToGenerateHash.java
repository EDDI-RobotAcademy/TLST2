package kr.eddi.ztz_process.utility.encrypt.exception;

public class UnableToGenerateHash extends RuntimeException {

    public UnableToGenerateHash(String message) {
        super(message);
    }

    public UnableToGenerateHash(String message, Throwable cause) {
        super(message, cause);
    }
}
