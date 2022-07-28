package com.haroong.haroong1.service.mapper;

import com.haroong.haroong1.model.BoardModel;
import com.haroong.haroong1.repository.entity.BoardEntity;

import java.text.SimpleDateFormat;

public class BoardMapper {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static BoardModel mapBoardModel(BoardEntity boardEntity) {
        if (boardEntity == null) return null;

        BoardModel boardModel = new BoardModel();
        if (boardEntity.getBoardNo() != null) {
            boardModel.setBoardNo(boardEntity.getBoardNo());
        }
        boardModel.setCategory(boardEntity.getCategory());
        boardModel.setTitle(boardEntity.getTitle());
        if (boardEntity.getLikeCount() != null) {
            boardModel.setLikeCount(boardEntity.getLikeCount());
        }
        if (boardEntity.getFileNo() != null) {
            boardModel.setFileNo(boardEntity.getFileNo());
        }
        boardModel.setCreateId(boardEntity.getCreateId());
        if (boardEntity.getCreateDt() != null) {
            boardModel.setCreateDt(sdf.format(boardEntity.getCreateDt()));
        }
        boardModel.setUpdateId(boardEntity.getUpdateId());
        if (boardEntity.getUpdateDt() != null) {
            boardModel.setUpdateDt(sdf.format(boardEntity.getUpdateDt()));
        }
        return boardModel;
    }

    public static BoardEntity mapBoardEntity(BoardModel boardModel) {
        if (boardModel == null) return null;

        BoardEntity boardEntity = new BoardEntity();
        if (boardModel.getBoardNo() != null) {
            boardEntity.setBoardNo(boardModel.getBoardNo());
        }
        boardEntity.setCategory(boardModel.getCategory());
        boardEntity.setTitle(boardModel.getTitle());
        if (boardModel.getLikeCount() != null) {
            boardEntity.setLikeCount(boardModel.getLikeCount());
        }
        if (boardModel.getFileNo() != null) {
            boardEntity.setFileNo(boardModel.getFileNo());
        }
        boardEntity.setCreateId(boardModel.getCreateId());
        boardEntity.setUpdateId(boardModel.getUpdateId());
        return boardEntity;
    }
}
