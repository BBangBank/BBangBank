package bbang_bank.bank.repository;

import org.springframework.stereotype.Repository;

import bbang_bank.bank.entity.UserEntity;

@Repository
public interface UserRepository {
    
    UserEntity findByUserId (String userId);
}
