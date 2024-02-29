// import { Queue , QueueScheduler } from 'bullmq';

// const myQueueScheduler = new QueueScheduler('foo');

// const myQueue = new Queue("foo", {
//     defaultJobOptions:{
//         attempts: 3,
//         backoff: {
//             type: 'exponential',
//             delay: 10000
//         }
//     }
// });

// //add a job that will be delayed at least 5 seconds
// await myQueue.add('test-retry', { foo: 'bar' })