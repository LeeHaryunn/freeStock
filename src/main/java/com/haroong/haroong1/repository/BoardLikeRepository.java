package com.haroong.haroong1.repository;

import com.haroong.haroong1.repository.entity.BoardLikeEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BoardLikeRepository extends JpaRepository<BoardLikeEntity, Integer> {

    List<BoardLikeEntity> findByUserId(String userId);

    BoardLikeEntity findByBoardNoAndUserId(Integer boardNo, String userId);

    int deleteByBoardNoAndUserId(Integer bardNo, String userId);

}
