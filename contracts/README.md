# Fomo Agent Documentation

## *Introduction*

Fomo Agent is a revolutionary AI-driven betting platform designed to make betting interactive, engaging, and highly competitive. It addresses the dullness of traditional betting platforms by introducing a dynamic AI agent that manages bets, interacts with players, and ensures transparency while maintaining on-chain privacy.

---

## *Problem Statement*

Traditional betting platforms suffer from:

1. *Lack of Excitement:* Gameplay often relies on static, predictable mechanics.  
2. *Low Engagement:* Platforms do not leverage modern technologies like AI to drive user participation.  
3. *Trust Issues:* Players doubt the fairness of random number generation due to potential manipulation.  
4. *Limited Social Interactions:* Betting platforms lack innovative features like social proofing or community-driven excitement.  

---

## *Solution*

### *Fomo Agent: An AI Agent-Driven Betting Platform*

- *Host a Bet:* A user (hoster) initiates a bet with a predefined pot amount, e.g., $10,000.  
- *AI-Driven Interaction:* The Fomo Agent dynamically interacts with participants through encrypted and personalized messages.  
- *Player-Centric Gameplay:* Players compete against each other to predict the hoster's secret random number, making it a player-vs-player game, not against sheer probability.

---

## *How It Works*

### *1. Hosting a Bet*
1. *Initiate:*  
   The hoster creates a betting pot and locks the amount (e.g., $10,000) by calling an on-chain function.  

2. *Encryption and Security:*  
   - The hoster provides their private key encrypted using the Fomo Agent’s public key.  
   - The Fomo Agent decrypts and gains exclusive access to manage the pot.  
   - The hoster’s access is revoked to prevent tampering.  

3. *AI Agent’s Actions:*  
   - The AI generates a random number between 0 and the pot value ($10,000).  
   - This number and the agent’s wallet private key are encrypted using INCO's Access Control List (ACL).  
   - Encrypted data is stored in the origin contract as an NFT using the Walrus Protocol.

4. *Social Interaction:*  
   - The hoster specifies their Twitter ID.  
   - The AI agent posts on Twitter, tagging the hoster (e.g., @username) and announcing the hosted pot to create FOMO among players.

---

### *2. Player Participation*
1. *Bet Placement:*  
   - Players place their bets by transferring 1/10th of the amount they want to predict.  
   - Example: To predict $10,000, a player bets $1,000.  

2. *AI Interactions:*  
   - Players provide their email addresses during betting.  
   - The Fomo Agent sends private hints to players about their guesses, such as:  
     - “Your guess is higher than the target number.”  
     - “Your guess is lower than the target number.”  
   - Public observation is avoided to ensure fairness.  

3. *Hint System and Leaderboard:*  
   - Players can interact with the Fomo Agent to hunt for tweets and climb the leaderboard.  
   - Personalized hints like “The number is close to someone’s age multiplied by their age” are provided to enhance engagement.

---

### *3. End of Betting Period*
1. *Game Resolution:*  
   - At the end of the betting period, the encrypted random number and the wallet private key are decrypted.  
   - The winning player is determined based on proximity to the target random number.  

2. *Profit Distribution:*  
   - The hoster earns the profit generated from the pot after payouts to players.  
   - If only one player participates, they automatically win the pot.  

3. *Transparency:*  
   - The NFT ensures that all encrypted data and random number generation remain verifiable and immutable on-chain.

---

## *Unique Features*
1. *AI-Driven Engagement:*  
   - Generates personalized hints and feedback to enhance user experience.  
   - Posts real-time updates and announcements on social media to amplify FOMO.  

2. *On-Chain Privacy and Security:*  
   - Random numbers and private keys are securely encrypted using INCO's ACL.  
   - Data stored as NFTs ensures integrity and transparency.  

3. *Player-Versus-Player Gameplay:*  
   - Players compete against each other rather than against AI or platform-generated probabilities.

4. *Social Proofing:*  
   - Hosters can exaggerate wallet assets on social media to drive participation and excitement.  

5. *Dynamic Leaderboards and Hints:*  
   - Encourages player interaction and boosts community engagement.

---

## *Technical Components*
1. *Smart Contracts:*  
   - Handles pot creation, player participation, payouts, and NFT minting for encrypted data.  

2. *INCO Network:*  
   - Provides encryption and access control for secure data handling.  

3. *Walrus Protocol:*  
   - Ensures decentralized and secure NFT data storage.  

4. *Graph Polling Client:*  
   - Allows the Fomo Agent to monitor and respond to on-chain events in real-time.  

5. *AI Engine:*  
   - Powers personalized interactions, hint generation, and social media postings.

---

## *User Workflow*
1. *Hoster:*  
   - Creates a bet → Provides encrypted private key → Mentions Twitter ID → Receives profit.  

2. *Player:*  
   - Places a bet → Receives private hints → Competes for the pot → Wins or learns from the experience.  

---

## *Benefits*
- *Excitement:* Transforms betting into a dynamic and engaging experience.  
- *Transparency:* Secure and verifiable mechanisms for random number generation.  
- *Fairness:* AI ensures privacy and prevents manipulation or bias.  
- *Revenue:* Increased user participation through FOMO and social proofing.

---

## *Future Enhancements*
1. Integration with more social platforms for enhanced visibility.  
2. Advanced AI capabilities for better personalized hints and interactions.  
3. Expanding game types to include different betting mechanisms.

--- 

## *Conclusion*

Fomo Agent redefines betting by combining AI, blockchain, and privacy technologies to create a platform that is not only secure and transparent but also engaging and socially interactive. It is the future of on-chain betting.
