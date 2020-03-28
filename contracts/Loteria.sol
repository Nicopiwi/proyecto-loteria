pragma solidity >=0.4.22 <0.7.0;

contract Loteria {
    address payable manager;
    address payable[] participants;
    uint16 constant PARTICIPANTS_LIMIT = 300;
    uint16 participants_count;


    modifier managerOnly {
        require(msg.sender == manager, "");
        _;
    }
    //Generar un numero pseudoaleatorio teniendo en cuenta la dificultad del
    //bloque, el tiempo y los participantes
    function randomGenerator() private view returns (uint) {
    	return uint(keccak256(abi.encodePacked(block.difficulty, now, participants)));
    }
    constructor () public{
        manager = msg.sender;
        participants_count = 0;
    }
    function buy() public payable {
        require(participants_count<PARTICIPANTS_LIMIT, "Esta lleno");
        require(msg.value > 0.01 ether, "La transaccion debe ser de al menos 0.01 ether");
        participants.push(msg.sender);
        participants_count++;
    }
    function chooseWinner() public payable managerOnly{
        require(participants_count<=300, "Cantidad de participantes excedida");
        uint winner_pos = randomGenerator()%participants_count;
        address payable winner_addr = participants[winner_pos];
        winner_addr.transfer((address(this).balance*7)/10);
    }
    function setManager(address payable newManager_addr) public payable {
        newManager_addr.transfer(address(this).balance);
    }
}