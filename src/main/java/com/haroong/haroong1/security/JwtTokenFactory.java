package com.haroong.haroong1.security;

import java.util.UUID;
import javax.xml.bind.DatatypeConverter;

import com.haroong.haroong1.model.UserModel;
import com.haroong.haroong1.util.DateUtil;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.ClaimJwtException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;

/**
 * JWT 토큰 팩토리
 */
@Component
public class JwtTokenFactory {
    /**
     * 토큰 프리픽스
     */
    private static final String TOKEN_PREFIX = "Bearer ";

    /**
     * 발행자 아이디
     */
    private static final String ISSUER = "hslee";

    /**
     * 발행자 이메일
     */
    private static final String TOKEN_KEY = "kth4241@gmail.com";

    /**
     * 엑세스 토큰 만료한도 기본 10시간
     */
    private static final long EXPIRES_LIMIT = 600;

    /**
     * 리프레시 토큰 만료한도 기본 1달
     */
    private static final long EXPIRES_LIMIT_REFRESH = 720;

    /**
     * Access JWT 토큰 발행
     * @param userModel
     * @return
     */
    public String createAccessJwtToken(UserModel userModel) {
        Claims claims = Jwts.claims().setSubject(userModel.getUserId());

        claims.put("role", "user");
        String token = Jwts.builder().setClaims(claims).setIssuer(ISSUER)
                .claim("userNo", userModel.getUserNo())
                .claim("userId", userModel.getUserId())
                .claim("userName", userModel.getUserName())
                .claim("scope", "global")
                .setIssuedAt(DateUtil.nowToDate()).setExpiration(DateUtil.nowAfterMinutesToDate(EXPIRES_LIMIT))
                .signWith(SignatureAlgorithm.HS512, TOKEN_KEY).compact();

        return token;
    }

    /**
     * Refresh JWT 토큰 발행
     *
     * @param userModel
     * @return
     */
    public String createRefreshToken(UserModel userModel) {

        Claims claims = Jwts.claims().setSubject(userModel.getUserId());
        claims.put("role", "refresh");
        claims.put("userId", userModel.getUserId());

        String token = Jwts.builder().setClaims(claims).setIssuer(ISSUER).setId(UUID.randomUUID().toString())
                .setIssuedAt(DateUtil.nowToDate()).setExpiration(DateUtil.nowAfterHoursToDate(EXPIRES_LIMIT_REFRESH))
                .signWith(SignatureAlgorithm.HS512, TOKEN_KEY).compact();

        return token;
    }

    /**
     * 토큰 검증
     *
     * @param token
     * @return
     */
    public boolean verify(String token) {
        try {
            token = token.replace(TOKEN_PREFIX, "");
            Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(TOKEN_KEY)).parseClaimsJws(token);
            return true;
        }catch (SignatureException ex){
            System.out.println("Invalid JWT Signature");
        }catch (MalformedJwtException ex){
            System.out.println("Invalid JWT token");
        }catch (ExpiredJwtException ex){
            System.out.println("Expired JWT token");
        }catch (UnsupportedJwtException ex){
            System.out.println("Unsupported JWT exception");
        }catch (IllegalArgumentException ex){
            System.out.println("Jwt claims string is empty");
        }

        return false;
    }

    /**
     * 리프레시 토큰 검증
     *
     * @param token
     * @return
     */
    public boolean verifyRefreshToken(String token) {
        try {
            token = token.replace(TOKEN_PREFIX, "");
            Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(TOKEN_KEY)).parseClaimsJws(token);
            return true;
        }catch (SignatureException ex){
            System.out.println("Invalid JWT Signature");
        }catch (MalformedJwtException ex){
            System.out.println("Invalid JWT token");
        }catch (ExpiredJwtException ex){
            System.out.println("Expired JWT token");
        }catch (UnsupportedJwtException ex){
            System.out.println("Unsupported JWT exception");
        }catch (IllegalArgumentException ex){
            System.out.println("Jwt claims string is empty");
        }

        return false;
    }

    /**
     * 토큰 검증
     *
     * @param token
     * @return
     */
    public UserModel getUserModel(String token) {
        UserModel userModel;
        try {
            if (token == null) {
                return null;
            }
            token = token.replace(TOKEN_PREFIX, "");
            Jws<Claims> claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(TOKEN_KEY))
                    .parseClaimsJws(token);
            String userId = (String) claims.getBody().get("userId");
            Integer userNo = (Integer) claims.getBody().get("userNo");
            String userName = (String) claims.getBody().get("userName");
            userModel = new UserModel();
            userModel.setUserId(userId);
            userModel.setUserNo(userNo);
            userModel.setUserName(userName);
        } catch (ClaimJwtException | UnsupportedJwtException | MalformedJwtException | IllegalArgumentException e) {
            throw new RuntimeException("토큰 검증이 실패했습니다.", e.getCause());
        }

        return userModel;
    }

    /**
     * 아이디 추출
     *
     * @param token
     * @return userId
     */
    public String getLgnIdByRefreshToken(String token) {
        String userId;
        try {
            token = token.replace(TOKEN_PREFIX, "");
            Jws<Claims> claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(TOKEN_KEY))
                    .parseClaimsJws(token);
            userId = (String) claims.getBody().get("userId");


        } catch (ClaimJwtException | UnsupportedJwtException | MalformedJwtException | IllegalArgumentException e) {
            throw new RuntimeException("토큰 검증이 실패했습니다.", e.getCause());
        }

        return userId;
    }
}
