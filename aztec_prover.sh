#!/bin/bash
/root/.aztec/bin/aztec start --prover-broker --network alpha-testnet --port 8081 &
sleep 2
/root/.aztec/bin/aztec start --prover-agent --network alpha-testnet --port 8083 &
sleep 2
exec /root/.aztec/bin/aztec start --prover-node --archiver --network alpha-testnet --port 8082 \
  --prover.publisherPrivateKey "${ETH_PRIVATE_KEY}" \
  --prover.coordinationNodeUrl "${COORD_NODE_URL}" \
  --prover.brokerHost "${PROVER_BROKER_HOST}"
