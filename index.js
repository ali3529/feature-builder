#!/usr/bin/env node


const fs = require('fs');
const readline = require('readline');

// Function to capitalize the first letter of a string
function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

// Function to create feature base folder
function createFolder(folderName, pathRoute) {
    const capitalizedFolderName = capitalizeFirstLetter(folderName);
    const fullPath = `${pathRoute}/${folderName}`;

    fs.mkdirSync(`${fullPath}/slice`, { recursive: true });
    fs.mkdirSync(`${fullPath}/components`, { recursive: true });
    fs.mkdirSync(`${fullPath}/services`, { recursive: true });

    // Populate main folder index.ts
    fs.writeFileSync(`${fullPath}/index.ts`, 
`export * from './slice';
export * from './components';
export * from './services';
`);

    // export folder in index.ts
    fs.appendFileSync(`${pathRoute}/index.ts`, `export * from './${folderName}';\n`);

    // Populate slice folder index.ts
    fs.writeFileSync(`${fullPath}/slice/index.ts`, '// Add your slice exports here\n');

    // Populate components folder index.ts
    fs.writeFileSync(`${fullPath}/components/index.ts`, '// Add your component exports here\n');

    fs.writeFileSync(`${fullPath}/components/${capitalizedFolderName}Page.tsx`,
        `import React, { FC } from 'react';

interface I${capitalizedFolderName}PageProps {}

export const ${capitalizedFolderName}Page: FC<I${capitalizedFolderName}PageProps> = (props) => {
  return <div>${capitalizedFolderName}Page</div>;
};



`);

    // Create and populate Auth hook, service, and type files in the services folder
    fs.writeFileSync(`${fullPath}/services/${capitalizedFolderName}.hook.ts`, 
`export const ${folderName}Hook = {
  mutation: {},
  useQuery: {},
  prefetch: {},
};
`);

    //create export for service
    fs.writeFileSync(`${fullPath}/services/${capitalizedFolderName}.service.ts`, 
`export const ${folderName}Service = {
};
`);  

//create export for service
    fs.writeFileSync(`${fullPath}/services/${capitalizedFolderName}.type.ts`, 
`
`);

    fs.writeFileSync(`${fullPath}/components/index.ts`,
        `export {${capitalizedFolderName}Page} from './${capitalizedFolderName}Page.tsx';
`);

    // Populate services index.ts
    fs.writeFileSync(`${fullPath}/services/index.ts`, 
`export * from './${capitalizedFolderName}.hook';
export * from './${capitalizedFolderName}.service';
export * from './${capitalizedFolderName}.type';
`);

    console.log(`Folder '${folderName}' created and exported successfully!`);
}

// Default value for pathroute
const defaultPathroute = "./apps/pwa/src/features";

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Prompt the user for folder name
rl.question("Enter features base folder name: ", function(folderName) {
    // Prompt the user for path route
    rl.question(`Enter path route for the folder [Default: ${defaultPathroute}]: `, function(pathRouteInput) {
        const pathRoute = pathRouteInput || defaultPathroute;

        // Call the function to create the folder
        createFolder(folderName, pathRoute);

        rl.close();
    });
});
