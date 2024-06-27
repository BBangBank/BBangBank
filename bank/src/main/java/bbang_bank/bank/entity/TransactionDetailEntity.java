package bbang_bank.bank.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name = "transactionDetail")
@Table(name = "transaction_detail")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class TransactionDetailEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer detailNumber;

    private Integer accountId;
    private Long amount;
    private String createAt;
    private String target;

}
