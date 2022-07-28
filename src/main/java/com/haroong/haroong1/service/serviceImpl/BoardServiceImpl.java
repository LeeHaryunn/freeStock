package com.haroong.haroong1.service.serviceImpl;

import com.haroong.haroong1.model.BoardModel;
import com.haroong.haroong1.model.FileModel;
import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.repository.BoardRepository;
import com.haroong.haroong1.repository.FileRepository;
import com.haroong.haroong1.repository.BoardLikeRepository;
import com.haroong.haroong1.repository.UserRepository;
import com.haroong.haroong1.repository.entity.BoardEntity;
import com.haroong.haroong1.repository.entity.FileEntity;
import com.haroong.haroong1.repository.entity.BoardLikeEntity;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.response.ResponseData;
import com.haroong.haroong1.service.BoardService;
import com.haroong.haroong1.service.FileService;
import com.haroong.haroong1.service.mapper.BoardMapper;
import com.haroong.haroong1.service.mapper.FileMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@Transactional
public class BoardServiceImpl implements BoardService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    FileService fileService;

    @Autowired
    BoardRepository boardRepository;

    @Autowired
    FileRepository fileRepository;

    @Autowired
    BoardLikeRepository boardLikeRepository;

    @Override
    public ResponseBuilder insertBoard(MultipartFile file, String title, String category, UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            if (file == null) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "파일이 비어있습니다.");
            }
            if (!StringUtils.hasLength(title)) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "제목이 비어있습니다.");
            }
            if (!StringUtils.hasLength(category)) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "카테고리가 비어있습니다.");
            }

            responseBuilder = fileService.uploadFile(file, userModel);
            if (responseBuilder.getStatusCode() != 200) {
                return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "파일 업로드 실패");
            }

            FileEntity fileEntity = (FileEntity) responseBuilder.getData();
            BoardEntity boardEntity = new BoardEntity();
            boardEntity.setFileNo(fileEntity.getFileNo());
            boardEntity.setTitle(title);
            boardEntity.setCategory(category);
            boardEntity.setCreateId(userModel.getUserId());
            boardEntity = boardRepository.save(boardEntity);

            return responseBuilder.apiBuilder(ResponseData.OK, boardEntity);
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "게시글 등록 실패");
        }
    }

    @Override
    public ResponseBuilder getBoardList(Integer lastNum, String category, UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            if (lastNum == null) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "게시번호가 비어있습니다");
            }
            if (!StringUtils.hasLength(category)) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "카테고리가 비어있습니다.");
            }

            List<BoardEntity> boardEntityList = boardRepository.findTop10ByCategoryAndBoardNoGreaterThan(category, lastNum);
            List<BoardModel> boardModelList = new ArrayList<>();
            List<Integer> fileNoList = new ArrayList<>();
            for (BoardEntity boardEntity : boardEntityList) {
                boardModelList.add(BoardMapper.mapBoardModel(boardEntity));
                fileNoList.add(boardEntity.getFileNo());
            }

            List<FileModel> fileModelList = fileService.getMultipleFiles(fileNoList);
            boardModelList.forEach(v -> {
                for (FileModel fileModel : fileModelList) {
                    if (v.getFileNo().equals(fileModel.getFileNo())) {
                        v.setFile(fileModel.getFile());
                        v.setFileName(fileModel.getFileName());
                        v.setUuid(fileModel.getUuid());
                        v.setFileExtension(fileModel.getFileExtension());
                        break;
                    }
                }
            });

            if (userModel != null) {
                List<BoardLikeEntity> boardLikeEntityList = boardLikeRepository.findByUserId(userModel.getUserId());
                boardModelList.forEach(v -> {
                    for (BoardLikeEntity boardLikeEntity : boardLikeEntityList) {
                        if (v.getBoardNo().equals(boardLikeEntity.getBoardNo())) {
                            v.setLiked("O");
                            break;
                        }
                    }
                });
            }

            return responseBuilder.apiBuilder(ResponseData.OK, boardModelList);
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "리스트 취득 실패");
        }
    }

    @Override
    public ResponseBuilder getBoard(Integer boardNo) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            BoardEntity boardEntity = boardRepository.findByBoardNo(boardNo);
            if (boardEntity == null) {
                return responseBuilder.apiBuilder(ResponseData.NO_SUCH_DATA, "존재하지 않는 게시글 번호입니다.");
            }

            FileEntity fileEntity = fileRepository.findByFileNo(boardEntity.getFileNo());
            byte[] fileByte = fileService.getFileByte(FileMapper.mapFileModel(fileEntity));

            if (Arrays.equals(fileByte, new byte[0])) {
                return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "파일 변환 실패");
            }

            BoardModel boardModel = BoardMapper.mapBoardModel(boardEntity);
            boardModel.setFile(fileByte);
            return responseBuilder.apiBuilder(ResponseData.OK, boardModel);
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "게시글 취득 실패");
        }
    }

    @Override
    public ResponseBuilder likeBoard(Integer boardNo, UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            if (boardNo == null) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "게시글 번호가 비어있습니다.");
            }

            BoardLikeEntity boardLikeEntity = boardLikeRepository.findByBoardNoAndUserId(boardNo, userModel.getUserId());
            if (boardLikeEntity == null) {
                // 좋아요 가능
                if (boardRepository.plusLikeCountByBoardNo(boardNo) < 1) {
                    return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "좋아요 실패");
                }
                boardLikeEntity = setBoardLikeEntity(boardNo, userModel.getUserId());
                boardLikeRepository.save(boardLikeEntity);
                return responseBuilder.apiBuilder(ResponseData.OK, "좋아요 성공", true);
            } else {
                // 좋아요 취소
                if (boardRepository.minusLikeCountByBoardNo(boardNo) < 1) {
                    return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "좋아요 취소 실패");
                }
                boardLikeEntity = setBoardLikeEntity(boardNo, userModel.getUserId());
                boardLikeRepository.deleteByBoardNoAndUserId(boardLikeEntity.getBoardNo(), boardLikeEntity.getUserId());
                return responseBuilder.apiBuilder(ResponseData.OK, "좋아요 취소 성공", false);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "서버 에러");
        }
    }

    @Override
    public ResponseBuilder myLike(UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();
        try {
            List<BoardLikeEntity> boardLikeEntityList = boardLikeRepository.findByUserId(userModel.getUserId());
            if (boardLikeEntityList == null) {
                return responseBuilder.apiBuilder(ResponseData.OK, "좋아요를 누른 글이 없습니다.", new ArrayList<>());
            }

            List<Integer> boardNoList = new ArrayList<>();
            for (BoardLikeEntity boardLikeEntity : boardLikeEntityList) {
                boardNoList.add(boardLikeEntity.getBoardNo());
            }
            List<BoardEntity> boardEntityList = boardRepository.findByBoardNoInOrderByCategory(boardNoList);

            List<Integer> fileNoList = new ArrayList<>();
            List<BoardModel> boardModelList = new ArrayList<>();
            for (BoardEntity boardEntity : boardEntityList) {
                fileNoList.add(boardEntity.getFileNo());
                boardModelList.add(BoardMapper.mapBoardModel(boardEntity));
            }
            List<FileEntity> fileEntityList = fileRepository.findByFileNoIn(fileNoList);

            boardModelList.forEach(v -> {
                for (FileEntity fileEntity : fileEntityList) {
                    if (v.getFileNo().equals(fileEntity.getFileNo())) {
                        v.setFileName(fileEntity.getFileName());
                        break;
                    }
                }
            });

            return responseBuilder.apiBuilder(ResponseData.OK, boardModelList);
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "좋아요 목록 조회 실패");
        }
    }

    private BoardLikeEntity setBoardLikeEntity(Integer boardNo, String userId) {
        BoardLikeEntity boardLikeEntity = new BoardLikeEntity();
        boardLikeEntity.setBoardNo(boardNo);
        boardLikeEntity.setUserId(userId);
        return boardLikeEntity;
    }
}
