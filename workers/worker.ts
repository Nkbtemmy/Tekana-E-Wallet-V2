import { Worker } from "bullmq";

const worker = new Worker('foo', async job =>{
    console.log(job.data)
})