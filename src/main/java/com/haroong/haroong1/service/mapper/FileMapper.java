package com.haroong.haroong1.service.mapper;

import com.haroong.haroong1.model.FileModel;
import com.haroong.haroong1.repository.entity.FileEntity;

import java.text.SimpleDateFormat;

public class FileMapper {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static FileModel mapFileModel(FileEntity fileEntity) {
        if (fileEntity == null) return null;

        FileModel fileModel = new FileModel();
        if (fileEntity.getFileNo() != null) {
            fileModel.setFileNo(fileEntity.getFileNo());
        }
        fileModel.setFileName(fileEntity.getFileName());
        fileModel.setUuid(fileEntity.getUuid());
        fileModel.setFileExtension(fileEntity.getFileExtension());
        fileModel.setCreateId(fileEntity.getCreateId());
        if (fileEntity.getCreateDt() != null) {
            fileModel.setCreateDt(sdf.format(fileEntity.getCreateDt()));
        }
        return fileModel;
    }

    public static FileEntity mapFileEntity(FileModel fileModel) {
        if (fileModel == null) return null;

        FileEntity fileEntity = new FileEntity();
        if (fileModel.getFileNo() != null) {
            fileEntity.setFileNo(fileModel.getFileNo());
        }
        fileEntity.setFileName(fileModel.getFileName());
        fileEntity.setUuid(fileModel.getUuid());
        fileEntity.setFileExtension(fileModel.getFileExtension());
        fileEntity.setCreateId(fileModel.getCreateId());
        return fileEntity;
    }
}
