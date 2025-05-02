#!/bin/bash
/root/.aztec/bin/aztec start \
  --node \
  --archiver \
  --sequencer \
  --network alpha-testnet \
  --l1-rpc-urls "${RPC_URL}" \
  --l1-consensus-host-urls "${BEACON_URL}" \
  --sequencer.validatorPrivateKey "${ETH_PRIVATE_KEY}" \
  --sequencer.coinbase "${COINBASE_ADDRESS}" \
  --p2p.p2pIp "${PUBLIC_IP}"
