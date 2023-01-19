package kr.eddi.ztz_process.entity.boards;

import lombok.Getter;

@Getter
public enum BoardAuthorityType {

    PRIVATE_AUTHORITY("비공개"),
    PUBLIC_AUTHORITY("공개");

    private final String boardAuthorityType;

    private BoardAuthorityType(String boardAuthorityType) {
        this.boardAuthorityType = boardAuthorityType;
    }
}
