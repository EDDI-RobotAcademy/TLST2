package kr.eddi.ztz_process.service.boards;

 import kr.eddi.ztz_process.controller.boards.request.CommentRequest;
import kr.eddi.ztz_process.entity.boards.QuestionComment;

import java.util.List;

public interface QuestionCommentService {
    public List<QuestionComment> questionCommentList(Long questionNo);

    public QuestionComment questionComment(Long questionNo);

    public void questionCommentRegister(CommentRequest commentRequest);

    public void modifyQuestionComment(Long questionCommentNo, CommentRequest commentRequest);

    public void questionCommentRemove(Long questionCommentNo);

}