package kr.eddi.ztz_process.service.boards;

 import kr.eddi.ztz_process.controller.boards.CommentRequest;
import kr.eddi.ztz_process.entity.boards.QuestionComment;

import java.util.List;

public interface QuestionCommentService {
    // 댓글 리스트
    public List<QuestionComment> questionCommentList(Long questionNo);

    // 댓글 등록
    public void questionCommentRegister(CommentRequest commentRequest);

    // 댓글 삭제
    public void questionCommentRemove(Long questionCommentNo);

}