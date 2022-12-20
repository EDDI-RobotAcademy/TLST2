package kr.eddi.ztz_process.repository.tour;


import kr.eddi.ztz_process.entity.member.Member;
import kr.eddi.ztz_process.entity.tour.Foundry;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface FoundryRepository extends JpaRepository<Foundry, Long> {
    @Query("select f from Foundry f where f.name = :name")
    Foundry findByFoundryName(String name);
}
