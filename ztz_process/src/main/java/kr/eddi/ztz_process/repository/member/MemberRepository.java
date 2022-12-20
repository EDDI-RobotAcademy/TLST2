package kr.eddi.ztz_process.repository.member;


import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.member.MemberProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    @Query("select m from Member m join fetch m.authentications where m.email = :email")
    Optional<Member> findByEmail(String email);

    @Query("select m from Member m join fetch m.authentications where m.id = :id")
    Member findByMemberId(Long id);

    @Query("select mf from MemberProfile mf join fetch mf.member where mf.id= :memberId")
    MemberProfile findProfileByMemberId(Long memberId);
}
