package com.haroong.haroong1.service;

import com.haroong.haroong1.model.FileModel;
import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.repository.entity.FileEntity;
import com.haroong.haroong1.response.ResponseBuilder;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileService {
    /**
     * 파일 업로드
     * @param uploadFile
     * @return
     */
    ResponseBuilder uploadFile(MultipartFile uploadFile, UserModel userModel);

    /**
     * 파일 다운로드
     * @param fileModel
     * @return
     */
    ResponseEntity<Resource> downloadFile(FileModel fileModel);

    byte[] getFileByte(FileModel fileModel);

    List<FileModel> getMultipleFiles(List<Integer> fileNoList);
}
