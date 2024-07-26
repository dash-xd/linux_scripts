function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
  let i  = 0; 
  async function mainLoop() {
    while (true) {
      console.log("minutes afk: ", i);
      await sleep(60000);
      i = i+1;
    }
  }
  mainLoop().catch(err => console.error(err));
  
