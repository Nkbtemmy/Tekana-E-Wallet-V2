import { Queue } from 'bullmq';

const myQueue = new Queue('foo');

async function addJob() {
    await myQueue.add('myJobName', { foo: 'bar'});
    await myQueue.add('myJobName', { qux: 'baz'});
    
}

addJob();