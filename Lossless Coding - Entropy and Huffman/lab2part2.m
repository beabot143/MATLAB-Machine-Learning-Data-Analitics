%% Build Huffman Tree (Step 1)

testSeq = 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM'

symbol_prob = myEntropy(testSeq);
symbol_prob = symbol_prob.';
HuffTree = sort(symbol_prob)

% Check correct size of tree
symbols = unique(testSeq);
n = length(symbols)
HuffTree_size = (2*n-1) * 4;
for i = 1:length(HuffTree)
    for j = 1:4
        HuffTree(i,2) = -1;
        HuffTree(i,3) = -1;
        HuffTree(i,4) = -1;
    end
end

loop_count = 0;
stop_loop = 0;
while (stop_loop < 1)
    
   symbol_prob = sort(symbol_prob); 
   a = symbol_prob(1);
   b = symbol_prob(2);
   c = a + b;
   a_index = find(HuffTree==a);
   b_index = find(HuffTree==b);

   loop_count1 = 0;
   counter1 = 0;
   while (loop_count1 ~= 1)
       if (HuffTree(a_index(counter1 + 1), 2) == -1)
            HuffTree((n + loop_count+1), :) = [c -1 a_index(counter1+1) -1];
            loop_count1 = loop_count1 + 1;
       end
       counter1 = counter1 + 1;
   end
   
   loop_count2 = 0;
   counter2 = 0;
   while (loop_count2 ~= 1)
       if HuffTree(a_index(counter2+1), 2) == -1
            HuffTree(a_index(counter2+1), 2) = (n+loop_count+1);
            loop_count2 = loop_count2 + 1;
       end
       counter2 = counter2 + 1;
   end
   
   loop_count3 = 0;
   counter3 = 0;
   while (loop_count3 ~= 1)
       if (HuffTree(b_index(counter3+1),2) == -1)
            HuffTree((n + loop_count+1), 4) = b_index(counter3+1);
            loop_count3 = loop_count3 + 1;
       end
       counter3 = counter3 + 1;
   end
      
   loop_count4 = 0;
   counter4 = 0;
   while (loop_count4 ~= 1)
       if HuffTree(b_index(counter4 + 1), 2) == -1
            HuffTree(b_index(counter4+1), 2) = (n+loop_count+1);
            loop_count4 = loop_count4 + 1;
       end
       counter4 = counter4 + 1;
   end

   if length(symbol_prob) > 2
        symbol_prob(1,:) = [];
        symbol_prob(1,:) = [];
        symbol_prob(length(symbol_prob)+1) = c;
   elseif length(symbol_prob) > 1
       symbol_prob(1,:) = [];
       symbol_prob(length(symbol_prob)+1) = c;
       stop_loop = 2;
   end
   
   loop_count = loop_count + 1;
end

%% Encode Huffman Tree (Step 2)
HuffTree(1,5) = '0';
n = length(HuffTree);
cell_HuffTree = num2cell(HuffTree);

loop_count = 0
while(loop_count ~= n)
    left = cell_HuffTree{n - loop_count, 3}
    right = cell_HuffTree{n - loop_count, 4}
    if left > -1 
        cell_HuffTree{left, 5} = strcat(cell_HuffTree{cell_HuffTree{left, 2}, 5}, '0')
    end
    if right > -1
        cell_HuffTree{right, 5} = strcat(cell_HuffTree{cell_HuffTree{right, 2}, 5}, '1')
    end
    
    loop_count = loop_count + 1;
end

%% Encode input sequence (Step 3)
testSeq = 'HUFFMAN IS THE BEST COMPRESSION ALGORITHM'

symbol_prob = myEntropy(testSeq);
symbol_prob = symbol_prob.';
HuffTree = sort(symbol_prob);

symbols = unique(testSeq, 'stable');
n = length(symbols)
encoder = cell_HuffTree(1:n, :);
symbols = sort(symbols);
symbols = num2cell(symbols);

encoder{n, 6} = []
for i = 1:n
    encoder{i,6} = symbols{i}
end

encoded_code = '';

for i = 1:length(testSeq)
   sym_index = find(strcmp(encoder(:,6), testSeq(i))); %[encoder{:}] == testSeq(i));
   encoded_code = strcat(encoded_code, encoder{sym_index, 5});
end

%% Decode output sequence (Step 4)
s = ''
decoded_code = ''
for i = 1:length(encoded_code)
    s = strcat(s, encoded_code(i))
    if any(strcmp(encoder(:,5), s))
        index = find(strcmp(encoder(:,5), s));
        if encoder{index,6} == ' '
            decoded_code = strcat(decoded_code, {' '});
            s = '';
        else
            decoded_code = strcat(decoded_code, encoder{index,6});
            s = '';
        end
    end
end

char(decoded_code)