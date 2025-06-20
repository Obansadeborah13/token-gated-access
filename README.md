# 🔐 TokenGatedAccess — Token-Based Permission Control Smart Contract

**TokenGatedAccess** is a flexible and secure smart contract that enables decentralized applications to restrict access to certain functions or resources based on ownership of specific ERC20 or ERC721 tokens. It provides a robust foundation for building token-gated experiences such as exclusive content, membership access, or privileged features.

---

## 🚀 Features

- 🪙 **Supports ERC20 & ERC721 Token Gating**
  - Restrict access based on ERC20 token balance or ERC721 NFT ownership.
  - Configurable gating parameters for maximum flexibility.

- 🔑 **Access Control Modifiers**
  - `onlyTokenHolder` modifier enforces token ownership checks on sensitive functions.
  
- ⚙️ **Dynamic Gate Configuration**
  - Admin-controlled ability to set or update gating tokens and token IDs.
  - Supports fungible and non-fungible token gating scenarios.

- 📡 **Event Emission**
  - Emits events on gate updates and successful access, enabling easy off-chain tracking.

---

## 🧱 Contract Architecture

### Token Types Supported

```solidity
enum TokenType {
  ERC20,
  ERC721
}
Key Functions
solidity
function setGate(address tokenAddress, TokenType tokenType, uint256 tokenId) external onlyOwner;

function checkAccess(address user) external view returns (bool);

modifier onlyTokenHolder();
setGate: Configure the token and token type required for access. For ERC20 gating, tokenId is ignored.

checkAccess: Public view function to verify if a user meets gating criteria.

onlyTokenHolder: Modifier to restrict function calls to eligible token holders.

📦 Installation
Clone the repository and install dependencies:

bash
git clone https://github.com/yourusername/token-gated-access.git
cd token-gated-access
npm install
🚀 Deployment
Compile and deploy with Hardhat:

bash
npx hardhat compile
npx hardhat run scripts/deploy.js --network <network-name>
Set up environment variables for RPC URL and deployer key as needed.

🔍 Usage Example
Setting the Access Gate (Owner Only)
js
await tokenGatedAccess.setGate(
  "0xYourTokenAddress", 
  0, // TokenType.ERC20
  0  // tokenId ignored for ERC20
);
Gated Function Example
solidity
function exclusiveFeature() external onlyTokenHolder {
  // Function logic accessible only to token holders
}
Checking Access
js
const hasAccess = await tokenGatedAccess.checkAccess(userAddress);
console.log(`User access: ${hasAccess}`);
✅ Testing
Run the complete test suite with:

bash
npx hardhat test
Tests cover:

ERC20 and ERC721 gating scenarios

Access restriction enforcement

Gate configuration updates

Edge cases and unauthorized access attempts

🔐 Security Considerations
Access verification relies on OpenZeppelin ERC20/ERC721 interfaces.

Gate configuration restricted to contract owner.

Defensive checks against zero-address tokens and invalid parameters.

Thorough testing to prevent unauthorized access.

📁 Project Structure
bash
contracts/
├── TokenGatedAccess.sol       # Main contract

scripts/
├── deploy.js                  # Deployment script

test/
├── tokenGatedAccess.test.js   # Unit tests
