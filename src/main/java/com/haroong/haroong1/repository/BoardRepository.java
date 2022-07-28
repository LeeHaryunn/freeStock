package com.haroong.haroong1.repository;

import com.haroong.haroong1.repository.entity.BoardEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;

public interface BoardRepository extends JpaRepository<BoardEntity, Integer> {

    BoardEntity findByBoardNo(Integer boardNo);

    List<BoardEntity> findByCreateId(String createId);

    List<BoardEntity> findByCategory(String category);

    List<BoardEntity> findTop10ByCategoryAndBoardNoGreaterThan(String category, Integer boardNo);

    List<BoardEntity> findByBoardNoInOrderByCategory(Collection<Integer> boardNos);

    @Transactional
    @Modifying
    @Query("update BoardEntity b set b.likeCount = b.likeCount + 1 where b.boardNo = ?1")
    int plusLikeCountByBoardNo(Integer boardNo);

    @Transactional
    @Modifying
    @Query("update BoardEntity b set b.likeCount = b.likeCount - 1 where b.boardNo = ?1")
    int minusLikeCountByBoardNo(Integer boardNo);

}
