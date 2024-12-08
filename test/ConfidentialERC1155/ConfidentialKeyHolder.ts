import { expect } from "chai";
import { AbiCoder, AddressLike, Signature } from "ethers";

import { asyncDecrypt, awaitAllDecryptionResults } from "../asyncDecrypt";
import { createInstances } from "../instance";
import { getSigners, initSigners } from "../signers";
import { deployConfidentialKeyHolder } from "./ConfidentialKeyHolder.fixture";

const hre = require("hardhat");

describe("Confidential Key Holder Tests", function () {
  before(async function () {
    await initSigners();
    this.signers = await getSigners();
  });

  beforeEach(async function () {
    this.instances = await createInstances(this.signers);
    this.ConfidentialKeyHolder = await deployConfidentialKeyHolder();
    this.contractAddress = await this.ConfidentialKeyHolder.getAddress();
  });

  it("Should be able to Deploy Inco Contract ", async function () {
     console.log(this.contractAddress);
  });
});
