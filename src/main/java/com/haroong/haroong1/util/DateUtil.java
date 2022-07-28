package com.haroong.haroong1.util;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;

/**
 * 날짜 유틸
 */
public class DateUtil {

    /**
     * 현재 일자
     * @return
     */
    public static Date nowToDate() {
        return Date.from(LocalDateTime.now().toInstant(ZoneOffset.ofHours(9)));
    }

    /**
     * 현재 날짜로부터 요청파라미터 이후(분)
     * @param hours
     * @return
     */
    public static Date nowAfterMinutesToDate(Long hours) {
        return Date.from(LocalDateTime.now().plusMinutes(hours).toInstant(ZoneOffset.ofHours(9)));
    }

    /**
     * 현재 날짜로부터 요청파라미터 이후(시간)
     * @param hours
     * @return
     */
    public static Date nowAfterHoursToDate(Long hours) {
        return Date.from(LocalDateTime.now().plusHours(hours).toInstant(ZoneOffset.ofHours(9)));
    }
}
