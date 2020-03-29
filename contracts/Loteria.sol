pragma solidity >=0.4.22 <0.7.0;

import './LoteriaToken.sol';

contract Loteria {
    address token_contract_addr;
    address payable manager;
    address payable[] participants;
    uint16 constant PARTICIPANTS_LIMIT = 300;


    modifier managerOnly {
        require(msg.sender == manager, "Not manager");
        _;
    }
    //Generar un numero pseudoaleatorio teniendo en cuenta la dificultad del
    //bloque, el tiempo y los participantes
    function randomGenerator() private view returns (uint) {
    	return uint(keccak256(abi.encodePacked(block.difficulty, now, participants)));
    }


    constructor (address _token_contract_addr) public{
        manager = msg.sender;
        token_contract_addr = _token_contract_addr;
    }

    //Se deben mintear los tokens en la Loteria antes de que se transfieran los tokens
    //https://ethereum.stackexchange.com/questions/65899/transfer-erc20-token-from-a-smart-contract
    //LIMITE DE TICKETS EN UNA TRANSACCION = 100 TICKETS = 2.5M GAS
    function buy() public payable {
        require(participants.length<PARTICIPANTS_LIMIT, "Esta lleno");
        require(msg.value >= 0.001 ether, "El token cuesta un finney y no es divisible");
        require(msg.value <= 0.1 ether, "No se pueden comprar mas de 100 tickets");
        require(msg.value%1 finney==0, "El ticket no es divisible");
        uint participaciones = msg.value/1 finney;
        for (uint i = 0; i < participaciones; i++){
            participants.push(msg.sender);
        }
        LoteriaToken ltn = LoteriaToken(token_contract_addr);
        ltn.transfer(msg.sender, participaciones);
    }

    function chooseWinner() public payable managerOnly{
        require(participants.length==PARTICIPANTS_LIMIT, "La cantidad de participantes debe ser de 300");
        uint winner_pos = randomGenerator()%PARTICIPANTS_LIMIT;
        address payable winner_addr = participants[winner_pos];
        winner_addr.transfer((address(this).balance*7)/10);
        reset();
    }


    function setManager(address payable newManager_addr) public payable {
        newManager_addr.transfer(address(this).balance);
    }

    function reset() private {
        participants = new address payable[](0);
    }
}