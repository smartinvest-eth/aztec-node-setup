#!/bin/bash
/root/.aztec/bin/aztec start \
  --node \
  --archiver \
  --network alpha-testnet \
  --l1-rpc-urls "${RPC_URL}" \
  --l1-consensus-host-urls "${BEACON_URL}"
