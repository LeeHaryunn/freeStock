package com.haroong.haroong1.service.serviceImpl;

import com.haroong.haroong1.model.FileModel;
import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.repository.FileRepository;
import com.haroong.haroong1.repository.UserRepository;
import com.haroong.haroong1.repository.entity.FileEntity;
import com.haroong.haroong1.response.ResponseBuilder;
import com.haroong.haroong1.response.ResponseData;
import com.haroong.haroong1.service.FileService;
import com.haroong.haroong1.service.mapper.FileMapper;
import org.apache.commons.io.FilenameUtils;
import org.apache.tomcat.util.http.parser.MediaType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class FileServiceImpl implements FileService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    FileRepository fileRepository;

    @Value("${spring.servlet.multipart.location}")
    private String uploadPath;

    @Override
    public ResponseBuilder uploadFile(MultipartFile file, UserModel userModel) {
        ResponseBuilder responseBuilder = new ResponseBuilder();

        try {
            FileEntity fileEntity = new FileEntity();
            String uuid = UUID.randomUUID().toString();
            String extension = FilenameUtils.getExtension(file.getOriginalFilename());
            if (!StringUtils.hasText(extension)) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "확장자가 없습니다.");
            }

            String fileName = file.getOriginalFilename().replaceAll("." + extension, "");
            if (!StringUtils.hasText(fileName)) {
                return responseBuilder.apiBuilder(ResponseData.REQUEST_EMPTY, "파일명이 없습니다.");
            }

            // TODO 확장자 막기

            // Insert DB
            fileEntity.setFileExtension(extension);
            fileEntity.setFileName(fileName);
            fileEntity.setUuid(uuid);
            fileEntity.setCreateId(userModel.getUserId());
            fileRepository.save(fileEntity);

            // Upload file
            file.transferTo(transferFile(uuid, file.getOriginalFilename()));
            return responseBuilder.apiBuilder(ResponseData.OK, "파일 업로드 성공", fileEntity);
        } catch (Exception e) {
            e.printStackTrace();
            return responseBuilder.apiBuilder(ResponseData.INTERNAL_SERVER_ERROR, "파일 업로드 실패");
        }

    }

    @Override
    public ResponseEntity<Resource> downloadFile(FileModel fileModel) {
        try {
            Path path = getFilePath(fileModel);
            String contentType = Files.probeContentType(path);
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.add(HttpHeaders.CONTENT_TYPE, contentType);
            httpHeaders.set("Set-Cookie", "fileDownload=true;path=/");
            httpHeaders.set("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileModel.getFileName() + "." + fileModel.getFileExtension(), StandardCharsets.UTF_8));
            Resource resource = new InputStreamResource(Files.newInputStream(path));
            return new ResponseEntity<>(resource, httpHeaders, HttpStatus.OK);
        } catch (NoSuchFileException nfe) {
            nfe.printStackTrace();
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public List<FileModel> getMultipleFiles(List<Integer> fileNoList) {
        List<FileModel> resultList = new ArrayList<>();
        try {
            List<FileEntity> fileEntityList = fileRepository.findByFileNoIn(fileNoList);
            for (FileEntity fileEntity : fileEntityList) {
                FileModel fileModel = FileMapper.mapFileModel(fileEntity);
                fileModel.setFile(getFileByte(fileModel));
                resultList.add(fileModel);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public byte[] getFileByte(FileModel fileModel) {
        byte[] result = new byte[0];
        try (FileInputStream fileInputStream = new FileInputStream(transferFileModel(fileModel))) {
            result = fileInputStream.readAllBytes();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    private File transferFile(String uuid, String fileName) {
        return new File(uploadPath + File.separator + uuid + "_" + fileName);
    }

    private File transferFileModel(FileModel fileModel) {
        return new File(uploadPath + File.separator + fileModel.getUuid() + "_" + fileModel.getFileName() + "." + fileModel.getFileExtension());
    }

    private Path getFilePath(FileModel fileModel) {
        return Paths.get(uploadPath +
                File.separator + fileModel.getUuid() +
                "_" +
                fileModel.getFileName() +
                "." +
                fileModel.getFileExtension()
        );
    }
}
