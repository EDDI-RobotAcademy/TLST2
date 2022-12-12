package kr.eddi.ztz_process.service.reservation;

import kr.eddi.ztz_process.entity.reservation.Foundry;
import kr.eddi.ztz_process.repository.reservation.FoundryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoundryServiceImpl implements FoundryService{

    @Autowired
    FoundryRepository repository;

    @Override
    public List<Foundry> list() {
        return repository.findAll(Sort.by(Sort.Direction.DESC, "foundryId"));
    }
}
