package kr.eddi.ztz_process.repository.member;

import kr.eddi.ztz_process.entity.member.MemberProfile;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberProfileRepository extends JpaRepository<MemberProfile,Long> {
}
