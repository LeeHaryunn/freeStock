package com.haroong.haroong1.repository;

import com.haroong.haroong1.repository.entity.FileEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface FileRepository extends JpaRepository<FileEntity, Integer> {

    List<FileEntity> findByCreateId(String createId);

    FileEntity findByFileNo(Integer fileNo);

    List<FileEntity> findByFileNoIn(Collection<Integer> fileNos);

}
