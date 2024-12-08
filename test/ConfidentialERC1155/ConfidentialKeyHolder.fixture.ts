import { ethers } from "hardhat";

import type { IncoKeyContract } from "../../types";
import { getSigners } from "../signers";


export async function deployConfidentialKeyHolder(): Promise<IncoKeyContract> {
  const signers = await getSigners();

  const keyHolderFactory = await ethers.getContractFactory("IncoKeyContract");
  const keyHolder = await keyHolderFactory.connect(signers.alice).deploy("0x1950498e95274Dc79Fbca238C2BE53684D69886F");

  return keyHolder;
}
